import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Array;
import java.util.*;

public class Main {

    static ArrayList<Set<Integer>> tmp = new ArrayList<>();
    static int[][] li;
    static int N;
    static int M;
    static int K;
    static ArrayList<Integer> cctvs = new ArrayList<>(); // CCTV들의 숫자를 기록 (1~5)
    static int[] ix = {-1, 1, 0, 0}; // 상 하 좌 우
    static int[] iy = {0, 0, -1, 1};
    static ArrayList<Set<Integer>>[] book = new ArrayList[5];
    static int ans = 12354789;
    static void round(ArrayList<Set<Integer>> cctvDirections) {
        int cctvIndex = 0;
        int[][] board = new int[N][M];
        for(int i = 0; i < N ;i++){
            board[i] = li[i].clone();
        }
        for(int i = 0; i < N; i++) {
            for(int j = 0; j < M; j++) {
                if (board[i][j] <= 0 || board[i][j] == 6) { continue; }

                Set<Integer> directions = cctvDirections.get(cctvIndex++);

                for (int direction : directions) {
                    int x = i;
                    int y = j;
                    while (true) {
                        x = x + ix[direction];
                        y = y + iy[direction];
                        if (x < 0 || y < 0 || x >= N || y >= M || board[x][y] == 6) { break; }
                        if (board[x][y] != 0) { continue; } // cctv 보존하기
                        board[x][y] = -1;
                    }
                }
            }
        }
        int local = 0;
        for(int i = 0; i < N; i++) {
            for (int j = 0; j < M; j++) {
                local += board[i][j] == 0 ? 1 : 0;
            }
        }

        ans = Math.min(local, ans);
    }

    static void find(int n) {
        if(n == K) {
            round(tmp);
            return;
        }

        for(Set<Integer> directions: book[cctvs.get(n)-1]) {
            tmp.add(directions);
            find(n+1);
            tmp.remove(tmp.size()-1);
        }
    }
    static void makeBook() {
        book[0] = new ArrayList<>();
        book[0].add(new HashSet<>(Arrays.asList(0)));
        book[0].add(new HashSet<>(Arrays.asList(1)));
        book[0].add(new HashSet<>(Arrays.asList(2)));
        book[0].add(new HashSet<>(Arrays.asList(3)));

        book[1] = new ArrayList<>();
        book[1].add(new HashSet<>(Arrays.asList(0, 1)));
        book[1].add(new HashSet<>(Arrays.asList(2, 3)));

        book[2] = new ArrayList<>();
        book[2].add(new HashSet<>(Arrays.asList(0, 2)));
        book[2].add(new HashSet<>(Arrays.asList(0, 3)));
        book[2].add(new HashSet<>(Arrays.asList(1, 2)));
        book[2].add(new HashSet<>(Arrays.asList(1, 3)));

        book[3] = new ArrayList<>();
        book[3].add(new HashSet<>(Arrays.asList(0, 1, 2))); // 상 하 좌
        book[3].add(new HashSet<>(Arrays.asList(1, 2, 3))); // 하 좌 우
        book[3].add(new HashSet<>(Arrays.asList(2, 3, 0))); // 좌 우 상
        book[3].add(new HashSet<>(Arrays.asList(3, 0, 1))); // 우 상 좌

        book[4] = new ArrayList<>();
        book[4].add(new HashSet<>(Arrays.asList(0, 1, 2, 3)));
    }
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        StringBuilder sb = new StringBuilder();

        N = Integer.parseInt(st.nextToken());
        M = Integer.parseInt(st.nextToken());
        li = new int[N][M];

        for(int i = 0; i < N; i++) {
            st = new StringTokenizer(br.readLine());
            for(int j = 0; j < M; j++) {
                li[i][j] = Integer.parseInt(st.nextToken());
                if (li[i][j] != 6 && li[i][j] != 0) {
                    K++;
                    cctvs.add(li[i][j]);
                }
            }
        }
        makeBook();
        find(0);
        System.out.println(ans);
    }
}
/*
5 5
5 1 6 1 4
6 0 1 6 3
2 5 0 0 0
0 6 0 0 0
6 0 6 6 6
 */