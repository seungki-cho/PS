import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.PriorityQueue;
import java.util.StringTokenizer;

public class Main {
    static ArrayList<Pair>[] adj;
    static int N;
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int P = Integer.parseInt(st.nextToken())-1;
        adj = new ArrayList[N];
        for(int i = 0; i < N; i++) {
            adj[i] = new ArrayList();
        }

        for(int i = 0; i < M; i++) {
            st = new StringTokenizer(br.readLine());
            int a = Integer.parseInt(st.nextToken()) - 1;
            int b = Integer.parseInt(st.nextToken()) - 1;
            int wei = Integer.parseInt(st.nextToken());
            wei = (a == P || b == P ? (2*wei+1) : ((2*wei)));
            adj[a].add(new Pair(b, wei));
            adj[b].add(new Pair(a, wei));
        }
        if (find(0, P)/2 + find(P, N-1)/2 > find(0, N-1)/2 && find(0, N-1) % 2 == 0) {
            System.out.println("GOOD BYE");
        } else {
            System.out.println("SAVE HIM");
        }
    }

    static int find(int start, int end) {
        PriorityQueue<Pair> pq = new PriorityQueue<>((o1, o2) -> {
            return Integer.compare(o1.weight, o2.weight);
        });
        pq.add(new Pair(start, 0));

        boolean[] isv = new boolean[N];
        int[] w = new int[N];
        for(int i = 0; i < N; i++) {
            w[i] = 1_000_000_000;
        }
        while (!pq.isEmpty()){
            Pair t = pq.remove();
            if (isv[t.to] || w[t.to] < t.weight) { continue; }
            isv[t.to] = true;
            w[t.to] = t.weight;

            for(Pair toto: adj[t.to]) {
                if (isv[toto.to]) { continue; }
                if (w[toto.to] < toto.weight + w[t.to]) { continue; }
                pq.add(new Pair(toto.to, t.weight + toto.weight));
            }
        }
        return w[end];
    }
    static class Pair {
        int to;
        int weight;

        Pair(int to, int weight) {
            this.to = to;
            this.weight = weight;
        }
    }
}
/*

4 3
1 2 3 4
2 3 4 5
3 4 5 6
4 5 6 7
2 2 3 4
3 4 3 4
1 1 4 4


 */