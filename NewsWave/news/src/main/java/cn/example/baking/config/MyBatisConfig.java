package cn.example.baking.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

/**
 * 自动扫描
 */
@Configuration
@MapperScan(value = "cn.example.baking")
public class MyBatisConfig {
}
