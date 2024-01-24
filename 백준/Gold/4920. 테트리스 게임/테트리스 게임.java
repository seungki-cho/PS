import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.StringTokenizer;

/**
 * Main
 */
public class Main {
    static int[][][] helper = {
    {{0,0} ,{0,1},{0,2},{0,3}},
    {{0,0},{1,0},{2,0},{3,0}},
    {{0,0},{0,1},{1,1},{1,2}},
    {{0,1},{1,0},{1,1},{2,0}},
    {{0,0},{0,1},{0,2},{1,2}},
    {{0,0},{0,1},{1,0},{2,0}},
    {{0,0},{1,0},{1,1},{1,2}},
    {{0,1},{1,1},{2,1},{2,0}},
    {{0,0},{0,1},{1,0},{1,1}},
    {{0,0},{1,0},{1,1},{2,0}},
    {{0,1},{1,0},{1,1},{2,1}},
    {{0,1},{1,0},{1,1},{1,2}},
    {{0,0},{0,1},{0,2},{1,1}}
    };
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int n = 1;

        while ((N = Integer.parseInt(br.readLine().trim())) != 0) {
            StringTokenizer st;
            int localAns = -50000000;
            int[][] li = new int[N][N];
            for(int i = 0; i < N; i++) {
                st = new StringTokenizer(br.readLine());
                for(int j = 0; j < N; j++) {
                    li[i][j] = Integer.parseInt(st.nextToken().trim());
                }
            }
            for(int i = 0; i < N; i++) {
                for(int j = 0; j < N; j++) {
                    for(int k = 0; k < 13; k++) {
                        int local = 0;
                        boolean isfail = false;

                        for(int l = 0; l < 4; l++){
                            int x = i + helper[k][l][0];
                            int y = j + helper[k][l][1];
                            if (x < 0 || y < 0 || x >= N || y >= N) { isfail = true; break; }
                            local += li[x][y];
                        }
                        if (!(isfail)) { localAns = Math.max(localAns, local); }
                    }
                }
            }
            System.out.println(n++ + ". " + localAns);
        }
    }
    static int N;
}
/*

4 
70  70  70 70
7  1 30 6
4 30 30 5
3  1 30 2
4 
70  70  70 70
7  1 89 6
4 30 90 90
3  1 0 90
4
-1 -1 -1 -1
-1 -1 -1 -1
-1 -1 0 -1
-1 -1 -1 -1
 */