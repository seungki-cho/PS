import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.StringTokenizer;

public class Main {
    static int N;
    static int M;
    static int[][] op1(int[][] li) {
        int n = li.length;
        int m = li[0].length;
        int[][] l = new int[n][m];

        for(int i = 0; i < n; i++) {
            for(int j = 0; j < m; j++) {
                l[n-1-i][j] = li[i][j];
            }
        }

        return l;
    }
    static int[][] op2(int[][] li) {
        int n = li.length;
        int m = li[0].length;
        int[][] l = new int[n][m];
        for(int i = 0; i < n; i++) {
            for(int j = 0; j < m; j++) {
                l[i][m-1-j] = li[i][j];
            }
        }
        return l;
    }
    static int[][] op3(int[][] li) {
        int n = li.length;
        int m = li[0].length;
        int[][] l = new int[m][n];
        for(int i = 0; i < n; i++) {
            for(int j = 0; j < m; j++) {
                l[j][i] = li[n-1-i][j];
            }
        }
        return l;
    }
    static int[][] op4(int[][] li) {
        int n = li.length;
        int m = li[0].length;
        int[][] l = new int[m][n];
        for(int i = 0; i < n; i++) {
            for(int j = 0; j < m; j++) {
                l[m-j-1][i] = li[i][j];
            }
        }
        return l;
    }
    static void swapp(int[][] ret, int[][] li, int a, int b, int x, int y, int ax, int ay) {
        for(int i = 0; i < ax; i++) {
            for(int j = 0; j < ay; j++) {
                ret[a+i][b+j] = li[x+i][y+j];
            }
        }
    }
    static int[][] op5(int[][] li) {
        int n = li.length;
        int m = li[0].length;
        int[][] ret = new int[n][m];

        swapp(ret, li, 0, 0, 0, m/2, n/2, m/2);
        swapp(ret, li, 0, m/2, n/2, m/2, n/2, m/2);
        swapp(ret, li, n/2, m/2, n/2, 0, n/2, m/2);
        swapp(ret, li, n/2, 0, 0, 0, n/2, m/2);

        return ret;
    }
    static int[][] op6(int[][] li) {
        int n = li.length;
        int m = li[0].length;
        int[][] ret = new int[n][m];

        swapp(ret, li, 0, 0, n/2, 0, n/2, m/2);
        swapp(ret, li, n/2, 0, n/2, m/2, n/2, m/2);
        swapp(ret, li, n/2, m/2, 0, m/2, n/2, m/2);
        swapp(ret, li, 0, m/2, 0, 0, n/2, m/2);

        return ret;
    }
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        StringTokenizer st = new StringTokenizer(br.readLine());
        N = Integer.parseInt(st.nextToken());
        M = Integer.parseInt(st.nextToken());
        int R = Integer.parseInt(st.nextToken());
        int[][] li = new int[N][M];

        for(int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            for(int j = 0; j < M; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
            }
        }   
        st = new StringTokenizer(br.readLine());

        for(int i = 0; i < R; i++) {
            switch (Integer.parseInt(st.nextToken())) {
                case 1:
                    li = op1(li);break;
                case 2:
                    li = op2(li);break;
                case 3:
                    li = op3(li);break;
                case 4:
                    li = op4(li);break;
                case 6:
                    li = op5(li);break;
                case 5:
                    li = op6(li);break;
            }
        }
        for(int i = 0; i < li.length; i++ ){
            for(int j = 0; j < li[0].length; j++) {
                sb.append(li[i][j]).append(" ");
            }
            sb.append("\n");
        }

        System.out.println(sb.toString());
    }
}