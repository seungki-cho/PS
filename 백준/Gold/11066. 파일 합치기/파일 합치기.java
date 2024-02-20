import java.io.*;
import java.util.*;

public class Main {
    static int[][] dp;
    static int[] sum;
    static int INF = 5_000_00112;

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        int T = Integer.parseInt(br.readLine());
        for(int t = 0; t < T; t++) {
            int N = Integer.parseInt(br.readLine());
            StringTokenizer st = new StringTokenizer(br.readLine());
            dp = new int[N][N];
            sum = new int[N+1];

            for(int i = 0; i < N; i++) {
                sum[i+1] = sum[i] + Integer.parseInt(st.nextToken());;
                for(int j = i+1; j < N; j++) {
                    dp[i][j] = INF;
                }
            }
            for(int i = 1; i < N; i++) {
                for(int j = 0; i+j < N; j++) {
                    int e = i + j;
                    for(int k = j; k < i+j; k++) {
                        dp[j][e] = Math.min(dp[j][e], dp[j][k] + dp[k+1][e] + sum[e+1] - sum[j]);
                    }
                }
            }
            sb.append(dp[0][N-1]).append("\n");
        }
        System.out.println(sb);
    }
}
/*
1
4
40 30 30 50
 */