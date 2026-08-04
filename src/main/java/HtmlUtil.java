package com.bootcamp.comparison;

import java.io.FileWriter;
import java.util.List;

public class HtmlUtil {

    public static void generateReport(List<ComparisonResult> results,
                                      String outputFile) throws Exception {

        FileWriter writer = new FileWriter(outputFile);

        writer.write("<html>");
        writer.write("<head>");
        writer.write("<title>Database Comparison Report</title>");

        writer.write("<style>");
        writer.write("body{font-family:Arial;padding:30px;}");
        writer.write("table{border-collapse:collapse;width:100%;}");
        writer.write("th,td{border:1px solid #ddd;padding:10px;text-align:left;}");
        writer.write("th{background:#007bff;color:white;}");
        writer.write(".MATCH{background:#d4edda;}");
        writer.write(".MISMATCH{background:#f8d7da;}");
        writer.write(".MISSING{background:#fff3cd;}");
        writer.write("</style>");

        writer.write("</head>");
        writer.write("<body>");

        writer.write("<h1>Database Comparison Report</h1>");

        writer.write("<table>");

        writer.write("<tr>");
        writer.write("<th>ID</th>");
        writer.write("<th>Source Name</th>");
        writer.write("<th>Target Name</th>");
        writer.write("<th>Source Rating</th>");
        writer.write("<th>Target Rating</th>");
        writer.write("<th>Status</th>");
        writer.write("</tr>");

        for (ComparisonResult result : results) {

            writer.write("<tr class='" + result.getStatus() + "'>");

            writer.write("<td>" + result.getId() + "</td>");
            writer.write("<td>" + result.getSourceName() + "</td>");
            writer.write("<td>" + result.getTargetName() + "</td>");
            writer.write("<td>" + result.getSourceRating() + "</td>");
            writer.write("<td>" + result.getTargetRating() + "</td>");
            writer.write("<td>" + result.getStatus() + "</td>");

            writer.write("</tr>");
        }

        writer.write("</table>");
        writer.write("</body>");
        writer.write("</html>");

        writer.close();

        System.out.println("HTML Report Generated : " + outputFile);

    }

}