package com.iclick.symphony.iaudience.controller;

import com.iclick.symphony.iaudience.util.JsonMapper;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

@Controller
@RequestMapping("/file")
public class FileController {
	
//	public final String UPLOAD_FOLDER = "/Users/wenjie.sun/upload/";
    public final String UPLOAD_FOLDER = "/var/upload/keyword/";
    @RequestMapping(value = "/uploadFile", method = RequestMethod.GET)
    public String uploadFileGet(HttpServletRequest request, Model model) {
    	return "audience/upload_file";
    }
    
    @RequestMapping(value = "/upload")
    public String uploadFile(HttpServletRequest request, HttpServletResponse response, Model model) throws IllegalStateException, IOException {
    	// 将当前上下文初始化给 CommonsMutipartResolver （多部分解析器）
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());

        String success = "true";
        //String message = CommonUtil.i18nStr(request, "文件上传成功", "File uppload success");
        String message = "File uppload success";
        String filePath = "";

        // 检查form中是否有enctype="multipart/form-data"
        if (multipartResolver.isMultipart(request)) {
          // 将request变成多部分request
          MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
          // 获取multiRequest 中所有的文件名
          Iterator<String> iter = multiRequest.getFileNames();

          while (iter.hasNext()) {
            // 一次遍历所有文件
            MultipartFile file = multiRequest.getFile(iter.next().toString());
            // 文件超大，不保存文件，给出提示
//            if (file != null && file.getSize() > (UPLOAD_MAX_SIZE * 1048576)) {
//              success = "false";
//              // message = "请上传不超过"+UPLOAD_MAX_SIZE+"M的文件";
//              message = CommonUtil.i18nStr(request, "请上传不超过" + UPLOAD_MAX_SIZE + "MB的文件",
//                  "Please check the file size, it must be less than" + UPLOAD_MAX_SIZE + "MB");
//              break;
//            }
            if (file != null) {
              filePath = UPLOAD_FOLDER + file.getOriginalFilename();
              file.transferTo(new File(filePath));
              break;// 一次只能上传一个文件
            }
          }
        }
        
        List<String> result = new ArrayList<>();
        if (StringUtils.isNotBlank(filePath)){
        	InputStream is = new FileInputStream(filePath);
        	XSSFWorkbook book = new XSSFWorkbook(is);
        	XSSFSheet sheet = book.getSheetAt(0);
        	if(sheet != null){
        		for(int rowNum = 0; rowNum <= sheet.getLastRowNum(); rowNum++){
        			XSSFRow row = sheet.getRow(rowNum);
        			result.add(row.getCell(0).toString());
        		}
        	}
        }

        Map<String, Object> map = new HashMap<>();
        map.put("success", success);
        map.put("message", message);
        map.put("result", result);
        JsonMapper mapper = JsonMapper.nonDefaultMapper();
        response.getWriter().print(mapper.toJson(map));
        response.getWriter().flush();
        response.getWriter().close();
        return null;
    }
}
