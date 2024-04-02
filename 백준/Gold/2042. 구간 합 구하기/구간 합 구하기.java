import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.StringTokenizer;

// 	메모리 109148KB	시간 508ms
public class Main {
    static long[] tree;

    static void init(long[] li) {
        int treeSize = li.length + 1;
        tree = new long[treeSize+1];

        for (int i = 1; i <= li.length; i++) {
            int j = i;

            while (j <= treeSize) {
                tree[j] += li[i-1];
                j += (j & -j);
            }
        }
    }
    static void update(int index, long diff) {
        int j = index;

        while (j <= tree.length) {
            tree[j] += diff;
            j += (j & -j);
        }
    }
    static long sum(int to) {
        int i = to;
        long ret = 0;

        while (i != 0) {
            ret += tree[i];
            i -= (i & -i);
        }

        return ret;
    }
    static long subSum(int from, int to) {
        return sum(to) - sum(from-1);
    }

    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());
        int N = Integer.parseInt(st.nextToken());
        int M = Integer.parseInt(st.nextToken());
        int K = Integer.parseInt(st.nextToken());
        int SUBSUM = 2;
        StringBuilder sb = new StringBuilder();

        long[] li = new long[N];
        for (int i = 0; i < N; i++) {
            li[i] = Long.parseLong(br.readLine());
        }
        init(li);
        for (int i = 0; i < M + K; i++) {
            st = new StringTokenizer(br.readLine());
            long command = Integer.parseInt(st.nextToken());
            int from = Integer.parseInt(st.nextToken());
            long to = Long.parseLong(st.nextToken());

            if (command == SUBSUM) {
                sb.append(subSum(from, (int)to)).append("\n");
            } else {
                update(from, to - li[from-1]);
                li[from-1] = to;
            }
        }
        System.out.println(sb);
    }
}