package com.allen.backend.repo;

import com.allen.backend.entity.ItemComment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ItemCommentRepository extends JpaRepository<ItemComment, Long> {
    List<ItemComment> findByShopItemIdOrderByCreatedAtDesc(Long shopItemId);
}
