package com.allen.backend.controller;

import com.allen.backend.dto.CommentResponse;
import com.allen.backend.service.ItemInteractionService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/items")
public class ItemInteractionController {

    private final ItemInteractionService itemInteractionService;

    public ItemInteractionController(ItemInteractionService itemInteractionService) {
        this.itemInteractionService = itemInteractionService;
    }

    @PostMapping("/{itemId}/like")
    public ResponseEntity<?> toggleLike(@PathVariable Long itemId, @RequestBody Map<String, Long> body) {
        try {
            Long userId = body.get("userId");
            if (userId == null) {
                return ResponseEntity.badRequest().body("userId is required");
            }

            boolean liked = itemInteractionService.toggleLike(userId, itemId);

            Map<String, Object> response = new HashMap<>();
            response.put("liked", liked);
            response.put("message", liked ? "Item liked successfully" : "Item unliked successfully");

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{itemId}/like/status")
    public ResponseEntity<?> getLikeStatus(@PathVariable Long itemId, @RequestParam Long userId) {
        try {
            boolean liked = itemInteractionService.isLiked(userId, itemId);

            Map<String, Boolean> response = new HashMap<>();
            response.put("liked", liked);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{itemId}/like/count")
    public ResponseEntity<?> getLikeCount(@PathVariable Long itemId) {
        try {
            int count = itemInteractionService.getLikeCount(itemId);

            Map<String, Integer> response = new HashMap<>();
            response.put("count", count);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/{itemId}/comments")
    public ResponseEntity<?> addComment(@PathVariable Long itemId, @RequestBody Map<String, Object> body) {
        try {
            Long userId = body.get("userId") != null ? ((Number) body.get("userId")).longValue() : null;
            String commentText = (String) body.get("commentText");

            if (userId == null) {
                return ResponseEntity.badRequest().body("userId is required");
            }
            if (commentText == null || commentText.trim().isEmpty()) {
                return ResponseEntity.badRequest().body("commentText is required");
            }

            CommentResponse comment = itemInteractionService.addComment(userId, itemId, commentText);
            return ResponseEntity.ok(comment);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error adding comment: " + e.getMessage());
        }
    }

    @GetMapping("/{itemId}/comments")
    public ResponseEntity<?> getComments(@PathVariable Long itemId) {
        try {
            List<CommentResponse> comments = itemInteractionService.getComments(itemId);
            return ResponseEntity.ok(comments);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/comments/{commentId}")
    public ResponseEntity<?> deleteComment(@PathVariable Long commentId) {
        try {
            itemInteractionService.deleteComment(commentId);
            return ResponseEntity.ok("Comment deleted successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error deleting comment: " + e.getMessage());
        }
    }
}
