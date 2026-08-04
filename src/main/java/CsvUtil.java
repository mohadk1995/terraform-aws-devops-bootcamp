package com.bootcamp.comparison;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVRecord;
import org.apache.commons.csv.CSVParser;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class CsvUtil {

    public static List<Review> readReviews(InputStream inputStream) throws Exception {

        List<Review> reviews = new ArrayList<>();

        Iterable<CSVRecord> records = CSVFormat.DEFAULT
                .builder()
                .setHeader()
                .setSkipHeaderRecord(true)
                .build()
                .parse(new InputStreamReader(inputStream, StandardCharsets.UTF_8));

        for (CSVRecord record : records) {

            Review review = new Review(
                Integer.parseInt(record.get(0)), // id
                record.get(5),                   // review text -> name
                (int) Double.parseDouble(record.get(3)) // rating
            );        

            reviews.add(review);
        }

        return reviews;
    }
}