import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static class Pair {
        int x;
        int y;
        int w;
        Pair(int x, int y, int w){
            this.x = x;
            this.y = y;
            this.w = w;
        }
    }
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        char[][] li = new char[N][M];
        int[][] isv = new int[N][M];

        for(int i = 0; i < N; i++) {
            li[i] = br.readLine().toCharArray();
        }

        LinkedList<Pair> q = new LinkedList<>();
        q.add(new Pair(0, 0, 1));
        isv[0][0] = 1;

        int[] ix = {0,0,1,-1};
        int[] iy = {1,-1,0,0};
        while(!q.isEmpty()) {
            Pair p = q.pollFirst();

            for(int i = 0; i < 4; i++){
                int x = p.x + ix[i];
                int y = p.y + iy[i];
                if (x < 0 || y < 0 || x >= N || y >= M || isv[x][y] != 0 || li[x][y] == '0') { continue; }
                q.add(new Pair(x, y, p.w + 1));
                isv[x][y] = p.w + 1;
            }
        }
        System.out.println(isv[N-1][M-1]);
    }

}