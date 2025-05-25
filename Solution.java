import java.io.*;
import java.util.*;
import java.util.stream.*;
import static java.util.stream.Collectors.joining;
import static java.util.stream.Collectors.toList;

class Result {

    /**
     * Complete the 'groupTransactions' function below.
     * @param transactions the function accepts STRING_ARRAY transactions as parameter.
     * @return the function is expected to return a STRING_ARRAY.
    */
    public static List<String> groupTransactions(List<String> transactions) {
        List<String> result = new ArrayList<>();

        Map<String, Integer> map = new HashMap<String, Integer>();
        for (String string : transactions) {
            if (map.containsKey(string)) {
                map.put(string, map.get(string) + 1);
            } else {
                map.put(string, 1);
            }
        }

        List<Map.Entry<String, Integer>> sorted_list = new ArrayList<>(map.entrySet());
        sorted_list.sort((a, b) -> {
            int cmp = Integer.compare(b.getValue(), a.getValue());
            if (cmp != 0) return cmp;
            return a.getKey().compareTo(b.getKey());
        });

        for (Map.Entry<String, Integer> entry : sorted_list) {
            String key = entry.getKey();
            int value = entry.getValue();
            result.add(key + " " + value); 
        }

        return result;       
    }
}


public class Solution {
    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(System.out));

        int transactionsCount = Integer.parseInt(bufferedReader.readLine().trim());

        List<String> transactions = IntStream.range(0, transactionsCount).mapToObj(i -> {
            try {
                return bufferedReader.readLine();
            } catch (IOException ex) {
                throw new RuntimeException(ex);
            }
        })
            .collect(toList());

        List<String> result = Result.groupTransactions(transactions);

        bufferedWriter.write(
            result.stream()
                .collect(joining("\n"))
            + "\n"
        );

        bufferedReader.close();
        bufferedWriter.close();
    }
}
