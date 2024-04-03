import java.io.*;
import java.util.*;

public class Solution {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        for (int t = 1, T = Integer.parseInt(br.readLine()); t <= T; t++) {
            int N = Integer.parseInt(br.readLine());
            int M = Integer.parseInt(br.readLine());
            ArrayList<Integer>[] child = new ArrayList[N];
            ArrayList<Integer>[] parent = new ArrayList[N];
            for (int i = 0; i < N; i++) {
                child[i] = new ArrayList<>();
                parent[i] = new ArrayList<>();
            }

            for (int i = 0; i < M; i++) {
                StringTokenizer st = new StringTokenizer(br.readLine());
                int a = Integer.parseInt(st.nextToken()) - 1;
                int b = Integer.parseInt(st.nextToken()) - 1;
                child[a].add(b);
                parent[b].add(a);
            }
            int ans = 0;

            for (int i = 0; i < N; i++) {
                ans += (bfs(child, i, N) + bfs(parent, i, N) == N - 1) ? 1 : 0;
            }
            sb.append("#" + t + " " + ans + "\n");
        }
        System.out.println(sb);
    }
    static int bfs(ArrayList<Integer>[] li, int n, int N) {
        int count = 0;
        boolean[] isv = new boolean[N];
        isv[n] = true;
        LinkedList<Integer> q = new LinkedList<>();
        q.add(n);

        while (!q.isEmpty()) {
            int f = q.pollFirst();

            for(int next: li[f]) {
                if (isv[next]) { continue; }
                q.add(next);
                isv[next] = true;
                count++;
            }
        }

        return count;
    }
}