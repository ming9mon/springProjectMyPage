package com.ming9.myPage.util;

public class utill {

	public static boolean stringNullCk(String val) {
		if(val == null || val.trim().length() == 0)
			return true;
		
		return false;
	}
}
