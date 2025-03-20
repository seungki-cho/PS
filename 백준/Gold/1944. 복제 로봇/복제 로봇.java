import java.io.*;
import java.util.*;

public class Main {
    static int N;
    static int[] uf;
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        ArrayList<Pair> edges = new ArrayList<>();
        ArrayList<Integer> vs = new ArrayList<>();
        HashMap<Integer, Integer> map = new HashMap<>();

        char[][] li = new char[N][N];

        for (int i = 0; i < N; i++) {
            li[i] = br.readLine().toCharArray();
            for (int j = 0; j < N; j++) {
                if (li[i][j] == 'S' || li[i][j] == 'K') {
                    vs.add(to1(i, j));
                    map.put(to1(i, j), vs.size() - 1);
                }
            }
        }

        int[] ix = new int[]{0, 0, 1, -1};
        int[] iy = new int[]{1, -1, 0, 0};
        for (int i = 0; i < vs.size(); i++) {
            boolean[][] isv = new boolean[N][N];
            int sx = vs.get(i) / N;
            int sy = vs.get(i) % N;

            ArrayDeque<Pair> q = new ArrayDeque<>();
            q.add(new Pair(sx, sy, 0));
            isv[sx][sy] = true;

            while (!q.isEmpty()) {
                Pair p = q.poll();
                for (int j = 0; j < 4; j++) {
                    int x = ix[j] + p.x;
                    int y = iy[j] + p.y;
                    if (x < 0 || y < 0 || x >= N || y >= N || isv[x][y] || li[x][y] =='1') continue;
                    if (li[x][y] == 'S' || li[x][y] == 'K') {
                        edges.add(new Pair(to1(sx, sy), to1(x, y), p.w + 1));
                    }
                    q.add(new Pair(x, y, p.w + 1));
                    isv[x][y] = true;
                }
            }
        }
        uf = new int[M + 1];
        Arrays.fill(uf, -1);
        int vc = 1;
        int ans = 0;

        Collections.sort(edges);
        for (int i = 0; i < edges.size() && vc < M + 1; i++) {
            int ai = map.get(edges.get(i).x);
            int bi = map.get(edges.get(i).y);
            if (find(ai) == find(bi)) continue;
            merge(ai, bi);

            vc += 1;
            ans += edges.get(i).w;
        }
        int a = find(0);
        boolean isFail = false;
        for (int i = 1; i < M+1; i++) {
            isFail |= find(i) != a;
        }

        if (isFail) {
            System.out.println(-1);
        } else {
            System.out.println(ans);
        }
    }

    static int find(int n) {
        if (uf[n] < 0) return n;
        return uf[n] = find(uf[n]);
    }

    static void merge(int x, int y) {
        uf[find(x)] = find(y);
    }

    static int to1(int x, int y) {
        return x * N + y;
    }

    static int[] to2(int n) {
        return new int[]{n / N, n % N};
    }
    static class Pair implements Comparable<Pair>{
        int x, y, w;
        public Pair(int from, int to, int w) {
            this.x = from;
            this.y = to;
            this.w = w;
        }

        @Override
        public int compareTo(Pair o) {
            return Integer.compare(w, o.w);
        }

        @Override
        public String toString() {
            return "Pair{" +
                    "x=" + x +
                    ", y=" + y +
                    ", w=" + w +
                    '}';
        }
    }
}

/*
5 2
11111
10001
10001
1KSK1
11111

 */