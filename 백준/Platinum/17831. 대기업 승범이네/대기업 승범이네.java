import java.io.*;
import java.util.*;
public class Main {
    static ArrayList<Integer>[] child;
    static int[] ws;
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        StringTokenizer st = new StringTokenizer(br.readLine());
        child = new ArrayList[N];
        for (int i = 0; i < N; i++) {
            child[i] = new ArrayList<>();
        }

        for (int i = 1; i < N; i++) {
            int p = Integer.parseInt(st.nextToken())-1;
            child[p].add(i);
        }
        ws = new int[N];
        st = new StringTokenizer(br.readLine());
        for (int i = 0; i < N; i++) {
            ws[i] = Integer.parseInt(st.nextToken());
        }


        dp = new int[N][2];
        find(0);
        System.out.println(Math.max(dp[0][0], dp[0][1]));
    }

    static int[][] dp;

    static void find(int n) {

        int mi = 0;
        int m = 0;
        for (int i = 0; i < child[n].size(); i++) {
            int c = child[n].get(i);
            find(c);
            dp[n][0] += Math.max(dp[c][0], dp[c][1]);
        }
        for (int i = 0; i < child[n].size(); i++) {
            int c = child[n].get(i);
            dp[n][1] = Math.max(dp[n][1], dp[n][0] - Math.max(dp[c][0], dp[c][1]) + ws[c] * ws[n] + dp[c][0]);

        }

    }
}