package me.zhengjie.utils;

import me.zhengjie.base.ApiResponse;

public class ApiResponseUtil {

    public static ApiResponse success(int code, String msg) {
        return new ApiResponse(code, msg);
    }

    public static ApiResponse success(int code, String msg, Object data) {
        return new ApiResponse(code, msg, data);
    }

    public static ApiResponse error(int code, String msg) {
        return new ApiResponse(code, msg);
    }
    public static ApiResponse success() {
        return new ApiResponse(200, "操作成功");
    }

    public static ApiResponse error(int code, String msg, Object data) {
        return new ApiResponse(code, msg, data);
    }
}
