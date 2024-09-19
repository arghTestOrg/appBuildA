package com.techx.crud.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import lombok.Data;

@Document("customers")
@Data
public class Customer {
    @Id
    private String id;
    private String name;
    private String email;
}
