import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int K = Integer.parseInt(st.nextToken());
        int[][] li = new int[N][N];
        int[][] nut = new int[N][N];
        int[] ix = new int[]{-1, -1, -1, 0, 1, 1, 1, 0};
        int[] iy = new int[]{-1, 0, 1, 1, 1, 0, -1, -1};
        PriorityQueue<Integer>[][] tre = new PriorityQueue[N][N];
        for (int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            for (int j = 0; j < N; j++) {
                nut[i][j] = Integer.parseInt(st.nextToken());
                tre[i][j] = new PriorityQueue<>();
                li[i][j] = 5;
            }
        }

        for (int i = 0; i < M; i++) {
            st = new StringTokenizer(br.readLine());
            int x = Integer.parseInt(st.nextToken())-1;
            int y = Integer.parseInt(st.nextToken())-1;
            int old = Integer.parseInt(st.nextToken());
            tre[x][y].add(old);
        }
        for (int k = 0; k < K; k++) {
            int[][] ise = new int[N][N];

            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    ArrayList<Integer> tmp = new ArrayList<>();
                    int nu = 0;
                    while (!tre[i][j].isEmpty()) {
                        int tree = tre[i][j].poll();
                        if (li[i][j] >= tree) {
                            li[i][j] -= tree;
                            tmp.add(tree+1);
                            if (((tree + 1) % 5) == 0) {
                                ise[i][j] += 1;
                            }
                        } else {
                            nu += tree/2;
                        }
                    }
                    li[i][j] += nu;
                    tre[i][j] = new PriorityQueue<>(tmp);
                }
            }
            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    if (ise[i][j] == 0) { continue; }
                    for(int a = 0; a < ix.length; a++) {
                        int x = i + ix[a];
                        int y = j + iy[a];
                        if (x<0||y<0||x>=N||y>=N) {continue;}
                        for (int l = 0; l < ise[i][j]; l++) {
                            tre[x][y].add(1);
                        }
                    }
                }
            }
            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    li[i][j] += nut[i][j];
                }
            }
        }
        int ans = 0;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                ans += tre[i][j].size();
            }
        }
        System.out.println(ans);
    }
}
