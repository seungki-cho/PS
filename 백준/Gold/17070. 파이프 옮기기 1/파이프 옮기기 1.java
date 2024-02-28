import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        int[][][] dp = new int[3][N][N];
        int[][] li = new int[N][N];

        for (int i = 0; i < N; i++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            for (int j = 0; j < N; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
            }
        }

        dp[0][0][1] = 1;
        for (int i = 0; i < N; i++) {
            for (int j = 2; j < N; j++) {
                if (li[i][j] != 0) continue;

                dp[0][i][j] = dp[1][i][j - 1] + dp[0][i][j - 1];
                dp[2][i][j] = (i - 1 >= 0) ? (dp[2][i - 1][j] + dp[1][i - 1][j]) : 0;
                dp[1][i][j] = (i - 1 >= 0 && li[i - 1][j] == 0 && li[i][j - 1] == 0) ? (dp[1][i - 1][j - 1] + dp[2][i - 1][j - 1] + dp[0][i - 1][j - 1]) : 0;
            }
        }
//        for (int k = 0; k < 3; k++) {
//            for (int i = 0; i < N; i++) {
//                for (int j = 0; j < N; j++) {
//                    System.out.print(dp[k][i][j] + " ");
//                }
//                System.out.println();
//            }
//            System.out.println();
//        }
        System.out.println((dp[0][N - 1][N - 1] + dp[1][N - 1][N - 1]) + dp[2][N - 1][N - 1]);
    }
}