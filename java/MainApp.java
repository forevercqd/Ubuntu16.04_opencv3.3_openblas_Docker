import objectdetection.ObjectDetectionImplement;

public class MainApp{
    public static void main(String[] agrs){
        ObjectDetectionImplement impl = new ObjectDetectionImplement();
	impl.ObjectDetection("./input.jpg","./result.jpg");	
    }
}