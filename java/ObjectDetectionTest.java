/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import objectdetection.ObjectDetectionImplement;
import objectdetection.ObjectDetectionImplement.ProgressCallback;

/**
 * 
 * @author Administrator This is the test java file
 */
public class ObjectDetectionTest {
	/**
	 * @param args
	 *            the command line arguments
	 * @throws Exception
	 */
	public static void main(String[] args){
		boolean condion = true;

		System.out.println(System.getProperty("java.library.path"));
		System.out.println("sun.arch.data.model = "
				+ System.getProperty("sun.arch.data.model"));

		// TODO Auto-generated method stub

		Thread objectDetectionThread = new Thread(new Runnable() {

			public void run() {
				// TODO Auto-generated method stub
				execute_object_detection();
			}
		});

		objectDetectionThread.start();

		System.out.println("CQD, after objectDetectionThread.start()");
		try {
			objectDetectionThread.join();
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("CQD, after objectDetectionThread.join()");
	}

	public static void execute_object_detection() {
		int res = 0;
		boolean bVideoDetection = false;
		Thread threadProgress = null;
		final ObjectDetectionImplement object = new ObjectDetectionImplement();

		String srcImagePath = null;
		String dstImagePath = null;

		if (true) {
			srcImagePath = "./input.jpg";
			dstImagePath = "./result.jpg";
		} else {
			srcImagePath = "../../../data/input_1Bframe_3s.mp4";
			dstImagePath = "../../../data/input_1Bframe_3s.webp";
		}

		if (srcImagePath.endsWith(".mp4")) {
			bVideoDetection = true;
		}

		object.initialize();

		if (bVideoDetection) {
			object.setOnProgress(new ProgressCallback() {
				public void onProgress(int progress) {
					object.m_dwProgress = progress;
				}
			});

			threadProgress = new Thread(new Runnable() {

				public void run() {
					// TODO Auto-generated method stub
					while (100 != object.m_dwProgress) {
						System.out.println("thread m_dwProgress ="
								+ object.m_dwProgress);
						try {
							Thread.sleep(1000);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					}

				}

			});

			threadProgress.start();
		}

		System.out.println("xt thread ID:" + Thread.currentThread().getName());

		res = object.ObjectDetection(srcImagePath, dstImagePath);

		System.out.println("CQD, after object.ObjectDetection");

		if (bVideoDetection) {
			try {
				threadProgress.join();

			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		System.out.println("CQD, before object.unInitialize");

		object.unInitialize();

		System.out.println("CQD, after object.unInitialize");
	}
}
