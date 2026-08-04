package com.bootcamp.comparison;

public class ComparisonResult {

    private int id;
    private String sourceName;
    private String targetName;
    private int sourceRating;
    private int targetRating;
    private String status;

    public ComparisonResult(int id,
                            String sourceName,
                            String targetName,
                            int sourceRating,
                            int targetRating,
                            String status) {

        this.id = id;
        this.sourceName = sourceName;
        this.targetName = targetName;
        this.sourceRating = sourceRating;
        this.targetRating = targetRating;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public String getSourceName() {
        return sourceName;
    }

    public String getTargetName() {
        return targetName;
    }

    public int getSourceRating() {
        return sourceRating;
    }

    public int getTargetRating() {
        return targetRating;
    }

    public String getStatus() {
        return status;
    }
}