package com.wqm.common.easyui;

import java.util.List;

public class DataGridModel<T> {

	private List<T> rows;
	private long total;
	private Object other;
	private List<T> footer;

	private boolean ifException;

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public Object getOther() {
		return other;
	}

	public void setOther(Object other) {
		this.other = other;
	}

	public boolean getIfException() {
		return ifException;
	}

	public void setIfException(boolean ifException) {
		this.ifException = ifException;
	}

	public List<T> getFooter() {
		return footer;
	}

	public void setFooter(List<T> footer) {
		this.footer = footer;
	}

}
