import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;

public class Main {
    static class Heap {
        ArrayList<Integer> heap = new ArrayList<>();

        static int p(int n) { return (n-1)/2; }
        static int l(int n) { return n*2+1;}
        static int r(int n) { return (n+1)*2; }

        boolean isEmpty() {
            return heap.isEmpty();
        }

        boolean compare(Integer a, Integer b) {
            return (Math.abs(a) == Math.abs(b)) ? (a < b) : (Math.abs(a) < Math.abs(b));
        }

        void add(Integer elem) {
            heap.add(elem);

            int point = heap.size()-1;

            while (point != 0) {
                if (compare(heap.get(point), heap.get(p(point)))) {
                    Collections.swap(heap, point, p(point));
                    point = p(point);
                } else {
                    break;
                }
            }
        }

        Integer removeLast() {
            Collections.swap(heap, 0, heap.size()-1);
            Integer ret = heap.remove(heap.size()-1);
            int point = 0;

            while (r(point) <= heap.size()-1) {
                if (compare(heap.get(l(point)), heap.get(r(point)))) {
                    if (compare(heap.get(l(point)), heap.get(point))) {
                        Collections.swap(heap, l(point), point);
                        point = l(point);
                    } else {
                        break;
                    }
                } else {
                    if (compare(heap.get(r(point)), heap.get(point))) {
                        Collections.swap(heap, r(point), point);
                        point = r(point);
                    } else {
                        break;
                    }
                }
            }

            if (l(point) == heap.size()-1 && compare(heap.get(l(point)), heap.get(point))) {
                Collections.swap(heap, l(point), point);
            }
        
            return ret;
        }

    }
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        Heap heap = new Heap();

        int N = Integer.parseInt(br.readLine());
        for(int i = 0; i < N; i++) {
            int m = Integer.parseInt(br.readLine());
            if (m == 0) {
                sb.append(heap.isEmpty() ? 0 : heap.removeLast()).append("\n");
            } else {
                heap.add(m);
            }
        }
        System.out.println(sb.toString());
    }
}