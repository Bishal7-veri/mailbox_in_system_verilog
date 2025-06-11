//A mailbox is a first-in, first-out (FIFO) queue that can be used for synchronization and data exchange between parallel threads or classes.
// synchronisation is important to avoid race conditions

class producer ;
  mailbox #(int) mbx;
  function new ( mailbox #(int) mbx);
    this.mbx = mbx;
  endfunction
  task run();
    int data = 10;
    $display("Producer: putting %0d", data);
    mbx.put(data);
  endtask
endclass

class consumer ;
  mailbox #(int) mbx;
  function new ( mailbox #(int) mbx);
    this.mbx = mbx;
  endfunction
  task run();
    int rcv;
    mbx.get(rcv);
    $display("Consumer: got %0d", rcv);
  endtask
  
endclass

module tb;
  mailbox #(int) mb = new ();
  producer p = new(mb);
  consumer s = new(mb);
  initial
    begin
      fork
        p.run();
        s.run();
      join
    end
  
endmodule
