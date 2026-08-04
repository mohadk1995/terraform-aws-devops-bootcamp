package com.bootcamp.comparison;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CompareUtil {

    public static List<ComparisonResult> compare(List<Review> source,
                                                 List<Review> target) {

        List<ComparisonResult> results = new ArrayList<>();

        Map<Integer, Review> targetMap = new HashMap<>();

        for (Review review : target) {
            targetMap.put(review.getId(), review);
        }

        for (Review sourceReview : source) {

            Review targetReview = targetMap.get(sourceReview.getId());

            if (targetReview == null) {

                results.add(new ComparisonResult(
                        sourceReview.getId(),
                        sourceReview.getName(),
                        "NOT FOUND",
                        sourceReview.getRating(),
                        0,
                        "MISSING"
                ));

                continue;
            }

            String status = "MATCH";

            if (!sourceReview.getName().equals(targetReview.getName())
                    || sourceReview.getRating() != targetReview.getRating()) {

                status = "MISMATCH";
            }

            results.add(new ComparisonResult(
                    sourceReview.getId(),
                    sourceReview.getName(),
                    targetReview.getName(),
                    sourceReview.getRating(),
                    targetReview.getRating(),
                    status
            ));
        }

        return results;
    }

}