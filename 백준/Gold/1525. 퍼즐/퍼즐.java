import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayDeque;
import java.util.HashSet;
import java.util.StringTokenizer;

public class Main {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int init = 1;
        int[][] map = new int[][]{{1, 3}, {0, 2, 4}, {1, 5}, {0, 4, 6}, {1, 3, 5, 7}, {2, 4, 8}, {3, 7}, {4, 6, 8}, {5, 7}};
        int[] tens = new int[]{1, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000, 100_000_000};
        int ans = 1123456780;
        HashSet<Integer> isv = new HashSet<>();

        for (int i = 0; i < 3; i++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            for (int j = 0; j < 3; j++) {
                init *= 10;
                init += Integer.parseInt(st.nextToken());

            }
        }

        ArrayDeque<Integer> q = new ArrayDeque<>();

        q.add(init);
        int ret = -1;

        for (int k = 0; !q.isEmpty() && ret == -1; k++) {
            ArrayDeque nq = new ArrayDeque();
            while (!q.isEmpty()) {
                int bit = q.poll();

                int zi = 0;
                if (ans == bit) {
                    ret = k;
                    break;
                }
                for (int i = 0; i < 9; i++) {
                    zi = (bit / tens[i]) % 10 == 0 ? i : zi;
                }
                for (int i = 0; i < map[zi].length; i++) {
                    int j = map[zi][i];
                    int ten = tens[j];

                    int unit = (bit / ten) % 10;
                    int to = bit - (unit * ten) + unit * tens[zi];
                    if (!isv.contains(to)) {
                        isv.add(to);
                        nq.add(to);
                    }
                }
            }
            q = nq;
        }

        System.out.println(ret);
    }
}
