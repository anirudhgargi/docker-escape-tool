lib LibC
  fun getuid : UidT
end

def root?
    LibC.getuid==0
end
