import java.io.*;
import java.util.*;
public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        ArrayList<Pair> edges = new ArrayList<>();
        ArrayList<Integer>[] li = new ArrayList[N];
        for (int i = 0; i < N; i++) {
            li[i] = new ArrayList<>();
        }

        for (int i = 0; i < N-1; i++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            for (int j = i + 1; j < N; j++) {
                int w = Integer.parseInt(st.nextToken());
                edges.add(new Pair(i, j, w));
            }
        }
        Collections.sort(edges);
        uf = new int[N];
        Arrays.fill(uf, -1);
        int n = 1;

        for (int i = 0; i < edges.size() && n < N; i++) {
            int x = edges.get(i).x;
            int y = edges.get(i).y;
            if (find(x) == find(y)) continue;
            n++;
            merge(x, y);
            li[x].add(y);
            li[y].add(x);
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < N; i++) {
            sb.append(li[i].size()).append(" ");
            Collections.sort(li[i]);
            for (int j = 0; j < li[i].size(); j++) {
                sb.append(li[i].get(j)+1).append(" ");
            }
            sb.append("\n");
        }
        System.out.println(sb);
    }
    static int uf[];

    static int find(int n) {
        if (uf[n] < 0) return n;
        return uf[n] = find(uf[n]);
    }

    static void merge(int x, int y) {
        uf[find(x)] = find(y);
    }

    static class Pair implements Comparable<Pair> {
        int x, y, w;
        public Pair(int x, int y, int w) {
            this.x = x;
            this.y = y;
            this.w = w;
        }

        @Override
        public int compareTo(Pair o) {
            return Integer.compare(w, o.w);
        }
    }
}
