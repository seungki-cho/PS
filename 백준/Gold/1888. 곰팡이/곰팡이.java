import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.StringTokenizer;

/**
 * Main
 */
public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        M = Integer.parseInt(st.nextToken());
        
        li = new int[N][M];

        for(int i = 0; i < N; i++){
            String row = br.readLine();
            for(int j = 0; j < M; j++) {
                li[i][j] = Character.getNumericValue(row.charAt(j));
            }
        }
        
        isv = new boolean[N][M];
        for(int i = 0; i < N; i++){
            for(int j = 0; j < M; j++) {
                if (!isv[i][j] && li[i][j] != 0) {
                    findRoot(i, j);
                }
            }
        }
        
        int l = 0;
        while (!isLinked() && roots.size() > 1) {
            int[][] ne = new int[N][M];

            for(int k = 1; k < 6 ; k++) {
                for(int i = 0; i < N; i++) {
                    for(int j = 0; j < M; j++) {
                        if (li[i][j] != k) { continue; }
                        
                        for(int a = i - k; a <= i + k; a++) {
                            for(int b = j - k; b <= j + k; b++) {
                                if (a < 0 || b < 0 || a >= N || b >= M) { continue; }
                                ne[a][b] = k;
                            }
                        }
                    }
                }
            }
            // print(ne);
            l++;
            li = ne;

        }
        System.out.println(l);
     }
     static void print(int[][] li) {
        System.out.println();
        for(int i = 0; i < N; i++) {
            for(int j = 0; j < M; j++) {
                System.out.print(li[i][j]);
            }
            System.out.println();
        }
        System.out.println();
     }
     static boolean[][] isv;
     static int[][] li;
     static ArrayList<Pair> roots = new ArrayList<>();
     static int[] ix = {0,0,1,-1};
     static int[] iy = {1,-1,0,0};
     static int N;
     static int M;
     
     static void findRoot(int i, int j) {
        isv[i][j] = true;
        LinkedList<Pair> q = new LinkedList<>();
        roots.add(new Pair(i, j));
        q.add(new Pair(i, j));

        while (!q.isEmpty()) {
            Pair t = q.removeFirst();
            for(int k = 0; k < 4; k++) {
                int x = t.i + ix[k];
                int y = t.j + iy[k];

                if (x < 0 || y < 0 || x >= N || y >= M) { continue; }
                if (li[x][y] == 0 || isv[x][y]) { continue; }
                isv[x][y] = true;
                q.add(new Pair(x, y));
            }
        }
     }

     static boolean isLinked() {
        boolean[][] lisv = new boolean[N][M];
        if (roots.size() == 0) {
            return true;
        }
        Pair a = roots.get(0);
        lisv[a.i][a.j] = true;
        LinkedList<Pair> q = new LinkedList<>();
        q.add(a);

        while (!q.isEmpty()) {
            Pair t = q.removeFirst();
            for(int k = 0; k < 4; k++) {
                int x = t.i + ix[k];
                int y = t.j + iy[k];

                if (x < 0 || y < 0 || x >= N || y >= M) { continue; }
                if (li[x][y] == 0 || lisv[x][y]) { continue; }
                lisv[x][y] = true;
                q.add(new Pair(x, y));
            }
        }
        for(Pair ro: roots) {
            if (!lisv[ro.i][ro.j]) {
                return false;
            }
        }
        return true;
     }

     static class Pair {
        int i; 
        int j;
        Pair(int i, int j) {
            this.i = i;
            this.j = j;
        }
     }
}
/*

7 7
0000000
0000000
0000000
0002000
0000000
0000000
0000001

7 7
2000000
0000000
0000000
0000000
0000000
0000000
0000001

1 50
10000000000000000000000000000000000000000000000002

5 5
21000
11000
00000
00000
00001
*/