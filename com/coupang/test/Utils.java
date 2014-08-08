package com.coupang.test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Utils {

	private static final String AMAZON_HOME = "http://www.amazon.com/";

	public static CategoryNode buildCategoryChain(Elements liElements) {
		int size = liElements.size();
		int i = 0;
		CategoryNode root = null;
		CategoryNode current = null;
		CategoryNode pre = null;
		for(i = 0; i < size; i++) {
			Element li = liElements.get(i);
			current = new CategoryNode();
			if(i < size - 1) {
				Element spanLast = li.select("span").last();
				current.setCategoryName(spanLast.text());
			} else {
				Element strongElement = li.select("strong").first();
				current.setCategoryName(strongElement.text());
			}
			if(i == 0) {
				root = current;
				pre = current;
			} else {
				pre.setNext(current);
				current.setPre(pre);
				pre = current;
			}
		}
		return root;
	}
	
	public static List<CategoryNode> buildCategoryByUrl(String url) throws IOException {
		System.out.println("Trying to get url: " + url);
		Document document;
		try {
			document = Jsoup.connect(url).get();
		} catch(IOException e) {
			throw new IOException("Error when get " + url, e);
		}
		Elements elements = document.select("ul[data-typeid=n]");
		List<CategoryNode> nodes = new ArrayList<CategoryNode>();
		if(!elements.isEmpty()) {
			Element ul = elements.first();
			Elements liElements = ul.select("li");
			if(!liElements.isEmpty()) {
				Iterator<Element> iterator = liElements.iterator();
				while(iterator.hasNext()) {
					Element li = iterator.next();
					if(li.select("strong").size() > 0) {
						if(!iterator.hasNext()) {
							nodes.add(buildCategoryChain(liElements));
							break;
						}
						while(iterator.hasNext()) {
							Element childLi = iterator.next();
							String link = childLi.select("a").first().attr("href");
							if(!link.startsWith("http")) {
								link = AMAZON_HOME + link;
							}
							nodes.addAll(buildCategoryByUrl(link));
						}
					}
				}
			}
		}
		return nodes;
	}
}
