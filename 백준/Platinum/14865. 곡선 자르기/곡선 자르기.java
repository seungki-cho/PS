import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static class Pair implements Comparable<Pair> {
        int x;
        int y;
        boolean isContain;
        boolean isContained;
        Pair(int a, int b){
            x = a;
            y = b;
        }

        @Override
        public int compareTo(Pair o) {
            if (x == o.x) {
                return Integer.compare(o.y, y);
            }
            return Integer.compare(x, o.x);
        }

        @Override
        public String toString() {
            return x + " " + y + " " + (isContain ? 0 : 1) + " " + (isContained ? 0 : 1);
        }
    }
    public static void main(String[] args) throws Exception{
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        int N = Integer.parseInt(br.readLine());

        ArrayList<Pair> seq = new ArrayList<>();

        int xmin = 1234567890;
        int ymin = 1234567890;
        int startIndex = 0;

        for(int i = 0; i < N; i++) {
            StringTokenizer st = new StringTokenizer(br.readLine());
            int x = Integer.parseInt(st.nextToken());
            int y = Integer.parseInt(st.nextToken());

            seq.add(new Pair(x, y));
            if (ymin > y || (ymin == y && xmin > x)) {
                xmin = x;
                ymin = y;
                startIndex = i;
            }
        }


        int INF = 2_000_000_000;
        int startx, endx, prevx, prevy;
        prevx = prevy = startx = endx = INF;
        ArrayList<Pair> li = new ArrayList<>();

        for(int i = startIndex; i < startIndex+N; i++) {
            int x = seq.get(i%N).x;
            int y = seq.get(i%N).y;
            if(prevx == INF) {
                prevx = x;
                prevy = y;
                continue;
            }

            if ((prevy < 0 && y > 0) || (prevy > 0 && y < 0)) {
                if (startx == INF) {
                    startx = x;
                } else if (endx == INF) {
                    endx = x;
                    if (startx < endx) {
                        li.add(new Pair(startx, endx));
                    } else {
                        li.add(new Pair(endx, startx));
                    }
                    startx = INF;
                    endx = INF;

                } else {
                    startx = x;
                    endx = INF;
                }
            }
            prevx = x;
            prevy = y;
        }

        Collections.sort(li);

        PriorityQueue<Pair> pq = new PriorityQueue<>(Comparator.comparingInt(o -> o.y));

        int ansNotContained = 0;
        int ansNotContain = 0;

        for(int i = 0; i < li.size(); i++) {
            int x = li.get(i).x;
            int y = li.get(i).y;

            if (pq.isEmpty()) { pq.add(li.get(i)); continue; }

            while(!pq.isEmpty()) {
                if (pq.peek().x < x && pq.peek().y > y) {
                    pq.peek().isContain = true;
                    li.get(i).isContained = true;
                    pq.add(li.get(i));
                    break;
                } else {
                    pq.poll();
                }
            }

            pq.add(li.get(i));
        }
        for(int i = 0; i < li.size(); i++) {
            ansNotContained += (li.get(i).isContained ? 0 : 1);
            ansNotContain += (li.get(i).isContain ? 0 : 1);
        }

        System.out.println(ansNotContained + " " + ansNotContain);
    }
}

/*
12
-4 -4
-4 4
4 4
4 -3
3 -3
3 3
-3 3
-3 -3
-2 -3
-2 2
2 2
2 -4

14
-4 3
3 3
3 -2
1 -2
1 1
-1 1
-1 -1
-2 -1
-2 2
-3 2
-3 -2
0 -2
0 -4
-4 -4


[-4 3 1 1, -3 -2 1 1, -1 1 1 1]
[-4 -4 1 1, -2 -1 1 1, 1 3 1 1]
 */