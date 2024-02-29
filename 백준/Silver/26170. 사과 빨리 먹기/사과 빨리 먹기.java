import java.util.*;
import java.io.*;

public class Main {
    static int[][] li;
    static boolean[][] isv;
    static int[] ix = {0, 0, 1, -1};
    static int[] iy = {1, -1, 0, 0};
    static int currentEat = 0;
    static int minDistance = 123456;
    static void find(int i, int j, int distance) {
        if (currentEat == 3) {
            minDistance = Math.min(minDistance, distance);
            return;
        }
        isv[i][j] = true;

        for (int k = 0; k < ix.length; k++) {
            int x = i + ix[k];
            int y = j + iy[k];

            if (x < 0 || y < 0 || x >= 5 || y >= 5) { continue; }
            if (li[x][y]==-1 || isv[x][y]) { continue; }
            isv[x][y] = true;
            currentEat += (li[x][y] == 1 ? 1 : 0);
            find(x, y, distance+1);
            currentEat -= (li[x][y] == 1 ? 1 : 0);
            isv[x][y] = false;
        }
    }

    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        li = new int[5][5];
        isv = new boolean[5][5];

        for(int i = 0; i < 5; i++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            for (int j = 0; j < 5; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
            }
        }
        StringTokenizer st = new StringTokenizer(br.readLine());
        find(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()), 0);
        System.out.println(minDistance == 123456 ? -1 : minDistance);
    }
}