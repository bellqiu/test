package com.coupang.test;

import java.io.IOException;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MainStart {

	public static void main(String[] args) throws IOException {
		//http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dbaby-products
		/*Document document = Jsoup.connect("http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dbaby-products").get();
		Elements elements = document.select("ul[data-typeid=n]");
		if(elements != null) {
			Element ul = elements.first();
			if(ul != null) {
				System.out.println(ul.select("div").size());
				Elements liElements = ul.select("li");
				if(liElements != null) {
					boolean child = false;
					for(Element li : liElements) {
						if(li.select("strong").size() > 0) {
							child = true;
						} else {
							if(child) {
								
							}
						}
					}
				}
			}
			System.out.println(elements.size());
		}*/
		//List<CategoryNode> categoryNodes = Utils.buildCategoryByUrl("http://www.amazon.com/s/ref=sr_ex_n_1?rh=n%3A165796011%2Cn%3A%21165797011%2Cn%3A405369011&bbn=405369011&ie=UTF8&qid=1407486836");
		List<CategoryNode> categoryNodes = Utils.buildCategoryByUrl("http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dbaby-products");
		for(CategoryNode node : categoryNodes) {
			System.out.println(node);
		}
	}

}
