import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st;

        int N = Integer.parseInt(br.readLine());
        ArrayList<Pair>[] li = new ArrayList[N];

        for (int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            li[i] = new ArrayList<>();

            for (int j = 0; j < N; j++) {
                int weight = Integer.parseInt(st.nextToken());
                if (weight != 0) {
                    li[i].add(new Pair(j, weight));
                }
            }
        }

        st = new StringTokenizer(br.readLine());
        int P = Integer.parseInt(st.nextToken());
        int Q = Integer.parseInt(st.nextToken());

        int[][] trip = new int[P][2];
        int[][] home = new int[Q][2];

        for (int i = 0; i < P; i++) {
            st = new StringTokenizer(br.readLine());
            trip[i][0] = Integer.parseInt(st.nextToken()) - 1;
            trip[i][1] = Integer.parseInt(st.nextToken());
        }
        for (int i = 0; i < Q; i++) {
            st = new StringTokenizer(br.readLine());
            home[i][0] = Integer.parseInt(st.nextToken()) - 1;
            home[i][1] = Integer.parseInt(st.nextToken());
        }


        PriorityQueue<Pair> pq = new PriorityQueue<>();
        int[] dp = new int[N];
        Arrays.fill(dp, Integer.MAX_VALUE);
        for (int i = 0; i < P; i++) {
            int to = trip[i][0];
            int w = trip[i][1];

            pq.add(new Pair(to, -w));
            dp[to] = -w;
        }

        while (!pq.isEmpty()) {
            Pair p = pq.poll();

            if (dp[p.x] < p.w) continue;

            for (int i = 0; i < li[p.x].size(); i++) {
                int to = li[p.x].get(i).x;
                int w = p.w + li[p.x].get(i).w;


                if (dp[to] > w) {
                    pq.add(new Pair(to, w));
                    dp[to] = w;
                }
            }
        }

        int ans = Integer.MAX_VALUE;

        for (int i = 0; i < home.length; i++) {
            ans = Math.min(ans, dp[home[i][0]] - home[i][1]);
        }

        System.out.println(-ans);
    }

    static class Pair implements Comparable<Pair> {
        int x, w;
        public Pair(int x, int w) {
            this.x = x;
            this.w = w;
        }

        @Override
        public int compareTo(Pair o) {
            return Integer.compare(w, o.w);
        }
    }
}
