package com.bootcamp.comparison;

import java.util.List;

public class Main {

    private static final String BUCKET_NAME =
            "terraform-db-comparison-358487322112";

    private static final String SOURCE_FILE =
            "source/reviews.csv";

    private static final String TARGET_FILE =
            "target/reviews.csv";

    private static final String OUTPUT_FILE =
            "comparison.html";

    public static void main(String[] args) {

        try {

            System.out.println("Reading Source CSV...");

            List<Review> source =
                    S3Util.loadReviews(BUCKET_NAME, SOURCE_FILE);

            System.out.println("Reading Target CSV...");

            List<Review> target =
                    S3Util.loadReviews(BUCKET_NAME, TARGET_FILE);

            System.out.println("Comparing...");

            List<ComparisonResult> results =
                    CompareUtil.compare(source, target);

            HtmlUtil.generateReport(results, OUTPUT_FILE);

            System.out.println("Done.");

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}