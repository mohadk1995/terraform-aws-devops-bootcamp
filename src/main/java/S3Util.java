package com.bootcamp.comparison;

import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;
import software.amazon.awssdk.regions.Region;
import java.util.List;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;

public class S3Util {

    public static List<Review> loadReviews(String bucketName, String objectKey) throws Exception {

        S3Client s3Client = S3Client.builder()
        .region(Region.AP_SOUTH_1)
        .build();

        GetObjectRequest request = GetObjectRequest.builder()
                .bucket(bucketName)
                .key(objectKey)
                .build();

                ResponseInputStream<GetObjectResponse> object =
                s3.getObject(request);

        return CsvUtil.readReviews(object);
    }

}