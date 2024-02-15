    import java.io.BufferedReader;
    import java.io.InputStreamReader;
    import java.util.*;

    public class Main {
        static class Bosuck {
            long price;
            long weight;
            Bosuck(int weight, int price) {
                this.price = price;
                this.weight = weight;
            }

            @Override
            public String toString() {
                return "price : " + price + " weight : " + weight + "\n";

            }
        }
        public static void main(String[] args) throws Exception {
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
            StringTokenizer st = new StringTokenizer(br.readLine());
            int N = Integer.parseInt(st.nextToken());
            int M = Integer.parseInt(st.nextToken());
            PriorityQueue<Bosuck> pq = new PriorityQueue<>(new Comparator<Bosuck>() {
                public int compare(Bosuck o1, Bosuck o2) {
                    if (o1.weight > o2.weight) {
                        return 1;
                    } else if (o1.weight < o2.weight) {
                        return -1;
                    } else {
                        return Long.compare(o2.price, o1.price);
                    }
                }
            });
            PriorityQueue<Bosuck> pqprice = new PriorityQueue<>(new Comparator<Bosuck>() {
                public int compare(Bosuck o1, Bosuck o2) {
                    return Long.compare(o2.price, o1.price);
                }
            });

            for (int i = 0; i < N; i++) {
                st = new StringTokenizer(br.readLine());
                int weight = Integer.parseInt(st.nextToken());
                int price = Integer.parseInt(st.nextToken());
                pq.add(new Bosuck(weight, price));
            }

            int[] backs = new int[M];
            for (int i = 0; i < M; i++) {
                backs[i] = Integer.parseInt(br.readLine());
            }
            Arrays.sort(backs);
            
            long ans = 0;

            for (int back: backs) {
                while(!pq.isEmpty() && pq.peek().weight <= back) {
                    pqprice.add(pq.poll());
                }
                if (!pqprice.isEmpty()) {
                    ans += pqprice.poll().price;
                }
            }
            System.out.println(ans);
        }

    }