import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.SequenceInputStream;
import java.util.*;

public class Main {
    static class Pair{
        int x; int y;
        Pair(int a, int b) {
            x = a;
            y = b;
        }
    }

    static int[] ix = new int[]{0, 0, 1, -1};
    static int[] iy = new int[]{1, -1, 0, 0};
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());
        int[][] li = new int[N][N];
        for (int i = 0; i < N; i++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            for (int j = 0; j < N; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
            }
        }
        int ans = 12312313;
        for (int i = 0; i < N-1; i++) {
            for (int j = 1; j < N-1; j++) {
                for (int d1 = 1; d1 < N; d1++) {
                    for (int d2 = 1; d2 < N; d2++) {
                        if (i + d1 + d2 >= N || j - d1 < 0 || j + d2 >= N) {
                            continue;
                        }

                        int[][] isv = new int[N][N];
                        int x = i + d1 + d2; int y = j - d1 + d2; // 하
                        for (int k = 0; k <= d1; k++) {
                            isv[i + k][j - k] = 5;
                            isv[x - k][y + k] = 5;
                        }
                        for (int k = 0; k <= d2; k++) {
                            isv[i + k][j + k] = 5;
                            isv[x - k][y - k] = 5;
                        }


                        for (int k = i+1; k < x; k++) {
                            boolean isStart = false;
                            for (int l = 0; l < N; l++) {
                                if (isStart && isv[k][l] == 5) break;
                                isStart |= isv[k][l] == 5;
                                isv[k][l] = isStart ? 5 : isv[k][l];
                            }
                        }

                        int[] sums = new int[6];
                        for (int r = 0; r < N; r++) {
                            for (int c = 0; c < N; c++) {
                                if (isv[r][c] != 0) {
                                    sums[isv[r][c]] += li[r][c];
                                    continue;
                                }
                                if(r < i+d1 && c <= j) {
                                    isv[r][c] = 1;
                                } else if (r <= i+d2 && j < c) {
                                    isv[r][c] = 2;
                                } else if (i + d1 <= r && c < j-d1+d2) {
                                    isv[r][c] = 3;
                                } else {
                                    isv[r][c] = 4;
                                }
                                sums[isv[r][c]] += li[r][c];
                            }
                        }

                        int max = -1;
                        int min = 212312321;
                        for (int k = 1; k <= 5; k++) {
                            max = Math.max(sums[k], max);
                            min = Math.min(sums[k], min);
                        }
                        ans = Math.min(max - min, ans);

                    }
                }
            }
        }
        System.out.println(ans);
    }
}