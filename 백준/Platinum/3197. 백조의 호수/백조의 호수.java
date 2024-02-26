import java.io.*;
import java.sql.Array;
import java.util.ArrayDeque;
import java.util.Queue;
import java.util.StringTokenizer;

public class Main {
    static int[] ix = {0,0,1,-1};
    static int[] iy = {1,-1,0,0};
    static boolean[][] isv;
    static boolean[][] isMelt;
    static char[][] li;
    static int R, C;
    static Queue<Pair> connectionQ = new ArrayDeque<>();
    static Queue<Pair> meltQ = new ArrayDeque<>();
    static boolean[][] connectionIsv;

    public static void main(String[] argv) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        StringTokenizer st = new StringTokenizer(br.readLine());
        R = Integer.parseInt(st.nextToken());
        C = Integer.parseInt(st.nextToken());
        li = new char[R][C];
        int sx, sy, ex, ey;
        sx = sy = ex = ey = -1;

        for(int i = 0; i < R; i++) {
            li[i] = br.readLine().toCharArray();
            for(int j = 0; j < C; j++) {
                if (li[i][j] == 'L') {
                    if (sx == -1 ) {
                        sx = i;
                        sy = j;
                    } else {
                        ex = i;
                        ey = j;
                    }
                }
            }
        }

        int ans = 0;

        isv = new boolean[R][C];
        isMelt = new boolean[R][C];
        connectionIsv = new boolean[R][C];

        while(true) {
            if (canGo(sx, sy, ex, ey)) {
                break;
            }
            find();
            meltQ.forEach(pair -> {
                li[pair.x][pair.y] = '.';
            });

            ans++;
        }
        System.out.println(ans);
    }
    static boolean canGo(int sx, int sy, int ex, int ey) {
        if (connectionQ.isEmpty()) {
            connectionQ.add(new Pair(sx, sy));
            connectionIsv[sx][sy] = true;
        }

        Queue<Pair> nq = new ArrayDeque<>();

        while(!connectionQ.isEmpty()) {
            Pair p = connectionQ.poll();
            boolean isNear = false;

            for(int i = 0; i < ix.length; i++) {
                int X = p.x + ix[i]; int Y = p.y + iy[i];
                if (X < 0 || Y < 0 || X >= R || Y >=C || connectionIsv[X][Y]) { continue; }
                if (li[X][Y] == 'X') {
                    isNear = true;
                    continue;
                }

                connectionQ.add(new Pair(X, Y));
                connectionIsv[X][Y] = true;
                if (X == ex && Y == ey) {
                    return true;
                }
            }
            if (isNear) {
                nq.add(p);
            }
        }
        connectionQ = nq;
        return false;
    }

    static void find() {
        if(meltQ.isEmpty()) {
            for(int i = 0; i < R; i++) {
                for(int j = 0; j < C; j++) {
                    if (li[i][j] == 'X' || isv[i][j]) { continue; }
                    meltQ.add(new Pair(i, j));
                    isv[i][j] = true;
                }
            }
        }

        Queue<Pair> nq = new ArrayDeque<>();

        while (!meltQ.isEmpty()){
            Pair p = meltQ.poll();
            for(int i = 0; i < ix.length; i++) {
                int X = p.x + ix[i]; int Y = p.y + iy[i];
                if (X < 0 || Y < 0 || X >= R || Y >=C || isv[X][Y]) { continue; }
                if (li[X][Y] == 'X') {
                    nq.add(new Pair(X, Y));
                    isv[X][Y] = true; isMelt[X][Y] = true; continue;
                }
                isv[X][Y] = true;
                meltQ.add(new Pair(X, Y));
            }
        }
        meltQ = nq;
    }
    static class Pair {
        int x, y;
        Pair(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }
}