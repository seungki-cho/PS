import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int[] ind = new int[N];
        ArrayList<Integer>[] adj = new ArrayList[N];
        for(int i = 0; i < N; i++){
            adj[i] = new ArrayList<>();
        }

        for(int i = 0; i < M; i++) {
            st = new StringTokenizer(br.readLine());
            int b = Integer.parseInt(st.nextToken())-1;
            int a = Integer.parseInt(st.nextToken())-1;
            ind[a]++;
            adj[b].add(a);
        }

        PriorityQueue<Integer> q = new PriorityQueue<>();

        for(int i = 0; i < N; i++) {
            if (ind[i] == 0) {
                q.add(i);
            }
        }

        StringBuilder sb = new StringBuilder();
        while(!q.isEmpty()) {
            int x = q.poll();
            sb.append((x+1) + " ");
            for(int i = 0; i < adj[x].size(); i++) {
                int next = adj[x].get(i);
                if (--ind[next] == 0) {
                    q.add(next);
                }
            }
        }
        System.out.println(sb);
    }
}