# ReliaVib – Smartphone-based Vibration Analysis with MATLAB

ReliaVib is a project exploring the use of **smartphones as vibration sensors** for
predictive maintenance and condition monitoring.

📱 Data acquisition via **MATLAB Mobile**  
💻 Data analysis via **MATLAB Desktop/Online**  
🌀 Tested on an **AEG 6000 Series washing machine (@Electrolux Group)**

---

## 🚀 Features
- Acquire acceleration data directly from smartphone sensors
- Save `.mat` files for reproducible experiments
- Plot **time-domain** and **FFT** vibration data
- Annotate and detect **controlled impacts**
- First steps toward **alarm thresholds & anomaly detection**

---

## 📂 Repository structure
- `acquisition/` → Scripts for mobile data acquisition  
- `analysis/` → Scripts for visualization and FFT  
- `examples/` → Sample `.mat` files + images  
- `docs/` → Additional documentation and media  

---

## 🔧 How to use
1. Install **MATLAB Mobile** on your smartphone  
2. Run `ReliaVib_Acquire.m` to record vibrations  
3. Transfer `.mat` files to your desktop  
4. Run `ReliaVib_Analyze_WithAlarms.m` for plotting and anomaly detection  

---

## 📊 Example
Sample from washing machine test:

https://github.com/GianluigiRiccardi/Reliavib/blob/bec2025f7e3a25b9da114b5420713089732cb544/Reliavib%20P1%20.jpg

---

## 📚 References
- ISO 10816 – Mechanical vibration — Evaluation of machine vibration  
- Harris, C. M. *Shock and Vibration Handbook*, McGraw-Hill, 2002  
- MATLAB Mobile – [MathWorks](https://it.mathworks.com/help/matlabmobile/)  
- Experiment run on an iPhone – [Apple](https://www.apple.com)  
- AEG 6000 Series – [Electrolux Group](https://www.electroluxgroup.com)  

---

## 📝 License
Released under the MIT License.  
Gianluigi Riccardi
