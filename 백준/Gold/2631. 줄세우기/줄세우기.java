import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int[] li = new int[N];
        ArrayList<Integer> dp = new ArrayList<>();

        for(int i = 0; i < N; i++) { li[i] = Integer.parseInt(br.readLine()); }
        dp.add(li[0]);

        for(int i = 1; i < N; i++) {
            if (dp.get(dp.size()-1) < li[i]) {
                dp.add(li[i]);
                continue;
            }
            int index = Collections.binarySearch(dp, li[i]);
            dp.set(index < 0 ? index * -1 - 1 : index, li[i]);
        }
        System.out.println(N - dp.size());
    }
}