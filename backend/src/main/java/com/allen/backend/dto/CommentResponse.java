package com.allen.backend.dto;

import java.time.LocalDateTime;

public class CommentResponse {
    private Long id;
    private Long shopItemId;
    private Long userId;
    private String userName;
    private String commentText;
    private LocalDateTime createdAt;

    public CommentResponse() {}

    public CommentResponse(Long id, Long shopItemId, Long userId, String userName, String commentText, LocalDateTime createdAt) {
        this.id = id;
        this.shopItemId = shopItemId;
        this.userId = userId;
        this.userName = userName;
        this.commentText = commentText;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getShopItemId() {
        return shopItemId;
    }

    public void setShopItemId(Long shopItemId) {
        this.shopItemId = shopItemId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
