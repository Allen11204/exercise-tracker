package com.allen.backend.dto;

public class ShopItemResponse {
    private Long id;
    private String name;
    private String description;
    private Integer pointsRequired;
    private String imageUrl;
    private Integer stock;

    public ShopItemResponse() { }

    public ShopItemResponse(Long id, String name, String description, Integer pointsRequired, String imageUrl, Integer stock) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.pointsRequired = pointsRequired;
        this.imageUrl = imageUrl;
        this.stock = stock;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getPointsRequired() { return pointsRequired; }
    public void setPointsRequired(Integer pointsRequired) { this.pointsRequired = pointsRequired; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }
}
