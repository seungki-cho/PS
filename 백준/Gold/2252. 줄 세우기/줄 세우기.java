import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int[] in = new int[N];
        ArrayList<Integer>[] adj = new ArrayList[N];
        for(int i = 0; i < N; i++){
            adj[i] = new ArrayList<>();
        }

        for(int i = 0; i < M; i++) {
            st = new StringTokenizer(br.readLine());
            int a = Integer.parseInt(st.nextToken())-1;
            int b = Integer.parseInt(st.nextToken())-1;

            adj[a].add(b);
            in[b]++;
        }

        Queue<Integer> q = new ArrayDeque<>();
        for(int i = 0; i < N; i++) {
            if (in[i] == 0) {
                q.add(i);
            }
        }

        int[] ans = new int[N];
        int i = 0;
        while(!q.isEmpty()) {
            int me = q.poll();
            ans[i++] = me;
            for(int next: adj[me]) {
                in[next]--;
                if (in[next] == 0){
                    q.add(next);
                }
            }
        }
        StringBuilder sb = new StringBuilder();
        for(int next: ans) {
            sb.append((next + 1)).append(" ");
        }
        System.out.println(sb);
    }

}