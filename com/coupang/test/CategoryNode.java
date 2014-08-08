package com.coupang.test;

public class CategoryNode {

	private CategoryNode pre;

	private CategoryNode next;
	
	private String categoryName;
	
	public CategoryNode() {
		
	}
	
	public CategoryNode(CategoryNode pre, CategoryNode next, String categoryName) {
		this.pre = pre;
		this.next = next;
		this.categoryName = categoryName;
	}

	public CategoryNode getPre() {
		return pre;
	}

	public void setPre(CategoryNode pre) {
		this.pre = pre;
	}

	public CategoryNode getNext() {
		return next;
	}

	public void setNext(CategoryNode next) {
		this.next = next;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		CategoryNode root = this;
		while(root.pre != null) {
			root = root.pre;
		}
		while(root != null) {
			sb.append("-> " + root.getCategoryName());
			root = root.next;
		}
		return sb.toString();
	}
	
	
}
