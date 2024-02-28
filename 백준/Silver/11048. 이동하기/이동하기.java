import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());

        int[][] li = new int[N][M];
        int[][] dp = new int[N][M];

        for (int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            for (int j = 0; j < M; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
                dp[i][j] = li[i][j];
                dp[i][j] += Math.max(Math.max(((i - 1 >= 0) ? dp[i - 1][j] : 0), (j - 1 >= 0) ? dp[i][j - 1] : 0), ((i - 1 >= 0 && j - 1 >= 0) ? dp[i - 1][j - 1] : 0));
            }
        }
        System.out.println(dp[N-1][M-1]);
    }
}