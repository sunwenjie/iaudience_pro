package com.iclick.symphony.iapps.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/decorators")
public class DecoratorController {
    
    @RequestMapping("/main-decorator")
    public String mainDecorator(){
        
        return "decorators/main-decorator";
    }
    
    @RequestMapping("/message-decorator")
    public String messageDecorator(){
        
        return "decorators/message-decorator";
    }
}
