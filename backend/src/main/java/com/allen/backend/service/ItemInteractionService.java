package com.allen.backend.service;

import com.allen.backend.dto.CommentResponse;
import com.allen.backend.entity.ItemComment;
import com.allen.backend.entity.ItemLike;
import com.allen.backend.entity.User;
import com.allen.backend.repo.ItemCommentRepository;
import com.allen.backend.repo.ItemLikeRepository;
import com.allen.backend.repo.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ItemInteractionService {

    private final ItemLikeRepository itemLikeRepository;
    private final ItemCommentRepository itemCommentRepository;
    private final UserRepository userRepository;

    public ItemInteractionService(ItemLikeRepository itemLikeRepository,
                                  ItemCommentRepository itemCommentRepository,
                                  UserRepository userRepository) {
        this.itemLikeRepository = itemLikeRepository;
        this.itemCommentRepository = itemCommentRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public boolean toggleLike(Long userId, Long shopItemId) {
        boolean exists = itemLikeRepository.existsByUserIdAndShopItemId(userId, shopItemId);

        if (exists) {
            // Unlike: delete the like
            itemLikeRepository.deleteByUserIdAndShopItemId(userId, shopItemId);
            return false; // unliked
        } else {
            // Like: create new like
            ItemLike like = new ItemLike(shopItemId, userId);
            itemLikeRepository.save(like);
            return true; // liked
        }
    }

    public boolean isLiked(Long userId, Long shopItemId) {
        return itemLikeRepository.existsByUserIdAndShopItemId(userId, shopItemId);
    }

    public int getLikeCount(Long shopItemId) {
        return itemLikeRepository.countByShopItemId(shopItemId);
    }

    @Transactional
    public CommentResponse addComment(Long userId, Long shopItemId, String commentText) {
        // Fetch the user to get the username
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        // Create and save the comment
        ItemComment comment = new ItemComment(shopItemId, userId, commentText, user.getUsername());
        ItemComment savedComment = itemCommentRepository.save(comment);

        // Convert to response DTO
        return new CommentResponse(
                savedComment.getId(),
                savedComment.getShopItemId(),
                savedComment.getUserId(),
                savedComment.getUserName(),
                savedComment.getCommentText(),
                savedComment.getCreatedAt()
        );
    }

    public List<CommentResponse> getComments(Long shopItemId) {
        List<ItemComment> comments = itemCommentRepository.findByShopItemIdOrderByCreatedAtDesc(shopItemId);

        return comments.stream()
                .map(comment -> new CommentResponse(
                        comment.getId(),
                        comment.getShopItemId(),
                        comment.getUserId(),
                        comment.getUserName(),
                        comment.getCommentText(),
                        comment.getCreatedAt()
                ))
                .collect(Collectors.toList());
    }

    @Transactional
    public void deleteComment(Long commentId) {
        ItemComment comment = itemCommentRepository.findById(commentId)
                .orElseThrow(() -> new RuntimeException("Comment not found with id: " + commentId));
        itemCommentRepository.delete(comment);
    }
}
