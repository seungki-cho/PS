import java.io.*;
import java.lang.reflect.Array;
import java.util.*;
public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        uf = new int[N];
        StringTokenizer st = new StringTokenizer(br.readLine());
        adj = new ArrayList[N];
        linked = new ArrayList[N][2];


        for (int i = 0; i < N; i++) {
            uf[i] = Integer.parseInt(st.nextToken());
            adj[i] = new ArrayList<>();
            linked[i][0] = new ArrayList<>();
            linked[i][1] = new ArrayList<>();
            linked[i][1].add(i);
        }

        for (int i = 0; i < N-1; i++) {
            st = new StringTokenizer(br.readLine());
            int a = Integer.parseInt(st.nextToken()) - 1;
            int b = Integer.parseInt(st.nextToken()) - 1;
            adj[a].add(b);
            adj[b].add(a);
        }
        dp = new int[N][2];
        isv = new boolean[N];
        find(0);

        if (dp[0][0] > dp[0][1]) {
            System.out.println(dp[0][0]);
            Collections.sort(linked[0][0]);
            for (int i = 0; i < linked[0][0].size(); i++) {
                System.out.print(linked[0][0].get(i)+1 + " ");
            }
            System.out.println();
        } else {
            System.out.println(dp[0][1]);
            Collections.sort(linked[0][1]);
            for (int i = 0; i < linked[0][1].size(); i++) {
                System.out.print(linked[0][1].get(i)+1 + " ");
            }
            System.out.println();
        }
    }
    static ArrayList<Integer>[][] linked;
    static void find(int n) {
        if (isv[n]) return;
        isv[n] = true;
        dp[n][0] = 0;
        dp[n][1] = uf[n];
        int sum = 0;
        for (int i = 0; i < adj[n].size(); i++) {
            int c = adj[n].get(i);
            if(isv[c]) continue;

            find(c);
            dp[n][1] += dp[c][0];
            linked[n][1].addAll(linked[c][0]);

            if (dp[c][0] > dp[c][1]) {
                dp[n][0] += dp[c][0];
                linked[n][0].addAll(linked[c][0]);
            } else {
                dp[n][0] += dp[c][1];
                linked[n][0].addAll(linked[c][1]);
            }
        }
    }

    static int[][] dp;
    static boolean[] isv;
    static int uf[];
    static ArrayList<Integer>[] adj;

}