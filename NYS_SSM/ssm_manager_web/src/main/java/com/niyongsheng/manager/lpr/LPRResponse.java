package com.niyongsheng.manager.lpr;

/**
 * @author niyongsheng.com
 * @version $
 * @des 臻视摄像头返回数据模型
 * @updateAuthor $
 * @updateDes
 */
public class LPRResponse {
    private AlarmInfoPlate alarmInfoPlate;

    public AlarmInfoPlate getAlarmInfoPlate() {
        return alarmInfoPlate;
    }

    public void setAlarmInfoPlate(AlarmInfoPlate alarmInfoPlate) {
        this.alarmInfoPlate = alarmInfoPlate;
    }

    public static class AlarmInfoPlate {
        private Reslut result;
        private int channel;
        private String user_data;
        private String ipaddr;
        private String deviceName;
        private String serialno;

        public int getChannel() {
            return channel;
        }

        public void setChannel(int channel) {
            this.channel = channel;
        }

        public String getUser_data() {
            return user_data;
        }

        public void setUser_data(String user_data) {
            this.user_data = user_data;
        }

        public String getIpaddr() {
            return ipaddr;
        }

        public void setIpaddr(String ipaddr) {
            this.ipaddr = ipaddr;
        }

        public String getDeviceName() {
            return deviceName;
        }

        public void setDeviceName(String deviceName) {
            this.deviceName = deviceName;
        }

        public String getSerialno() {
            return serialno;
        }

        public void setSerialno(String serialno) {
            this.serialno = serialno;
        }

        public Reslut getResult() {
            return result;
        }

        public void setResult(Reslut result) {
            this.result = result;
        }

        public static class Reslut{
            private PlateResult plateResult;


            public PlateResult getPlateResult() {
                return plateResult;
            }

            public void setPlateResult(PlateResult plateResult) {
                this.plateResult = plateResult;
            }

            public static class  PlateResult{
                private int plateid;
                private int timeUsed;
                private String imagePath;
                private String imageFragmentFile;
                private String imageFile;
                private String imageFileLen;
                private String imageFragmentFileLen;
                private int confidence;
                private int bright;
                private int carBright;
                private int type;
                private String[] gioouts;
                private int colorType;
                private TimeStamp  timeStamp;
                private Integer isFakePlate;

                public Integer getIsFakePlate() {
                    return isFakePlate;
                }

                public void setIsFakePlate(Integer isFakePlate) {
                    this.isFakePlate = isFakePlate;
                }

                public String getImageFile() {
                    return imageFile;
                }

                public void setImageFile(String imageFile) {
                    this.imageFile = imageFile;
                }

                public String getImageFileLen() {
                    return imageFileLen;
                }

                public void setImageFileLen(String imageFileLen) {
                    this.imageFileLen = imageFileLen;
                }

                public static class TimeStamp{
                    private Timeval timeval;
                    public static class Timeval{
                        private String sec;
                        private int decmin;
                        private int decday;
                        private int decmon;
                        private int dechour;
                        private int usec;
                        private int decyear;
                        private int decsec;

                        public String getSec() {
                            return sec;
                        }

                        public void setSec(String sec) {
                            this.sec = sec;
                        }

                        public int getDecmin() {
                            return decmin;
                        }

                        public void setDecmin(int decmin) {
                            this.decmin = decmin;
                        }

                        public int getDecday() {
                            return decday;
                        }

                        public void setDecday(int decday) {
                            this.decday = decday;
                        }

                        public int getDecmon() {
                            return decmon;
                        }

                        public void setDecmon(int decmon) {
                            this.decmon = decmon;
                        }

                        public int getDechour() {
                            return dechour;
                        }

                        public void setDechour(int dechour) {
                            this.dechour = dechour;
                        }

                        public int getUsec() {
                            return usec;
                        }

                        public void setUsec(int usec) {
                            this.usec = usec;
                        }

                        public int getDecyear() {
                            return decyear;
                        }

                        public void setDecyear(int decyear) {
                            this.decyear = decyear;
                        }

                        public int getDecsec() {
                            return decsec;
                        }

                        public void setDecsec(int decsec) {
                            this.decsec = decsec;
                        }
                    }
                }
                private String license;
                private int carColor;
                private int isoffline;
                private int colorValue;
                private Location location;

                public  static class Location{
                    private RECT rect;

                    public static class RECT{
                        private int top;
                        private int left;
                        private int bottom;
                        private int right;

                        public int getTop() {
                            return top;
                        }

                        public void setTop(int top) {
                            this.top = top;
                        }

                        public int getLeft() {
                            return left;
                        }

                        public void setLeft(int left) {
                            this.left = left;
                        }

                        public int getBottom() {
                            return bottom;
                        }

                        public void setBottom(int bottom) {
                            this.bottom = bottom;
                        }

                        public int getRight() {
                            return right;
                        }

                        public void setRight(int right) {
                            this.right = right;
                        }
                    }
                }

                private int triggerType;
                private int direction;

                public String getImageFragmentFile() {
                    return imageFragmentFile;
                }

                public void setImageFragmentFile(String imageFragmentFile) {
                    this.imageFragmentFile = imageFragmentFile;
                }

                public String getImageFragmentFileLen() {
                    return imageFragmentFileLen;
                }

                public void setImageFragmentFileLen(String imageFragmentFileLen) {
                    this.imageFragmentFileLen = imageFragmentFileLen;
                }

                public int getPlateid() {
                    return plateid;
                }

                public void setPlateid(int plateid) {
                    this.plateid = plateid;
                }

                public int getTimeUsed() {
                    return timeUsed;
                }

                public void setTimeUsed(int timeUsed) {
                    this.timeUsed = timeUsed;
                }

                public String getImagePath() {
                    return imagePath;
                }

                public void setImagePath(String imagePath) {
                    this.imagePath = imagePath;
                }

                public int getConfidence() {
                    return confidence;
                }

                public void setConfidence(int confidence) {
                    this.confidence = confidence;
                }

                public int getBright() {
                    return bright;
                }

                public void setBright(int bright) {
                    this.bright = bright;
                }

                public int getCarBright() {
                    return carBright;
                }

                public void setCarBright(int carBright) {
                    this.carBright = carBright;
                }

                public int getType() {
                    return type;
                }

                public void setType(int type) {
                    this.type = type;
                }

                public String[] getGioouts() {
                    return gioouts;
                }

                public void setGioouts(String[] gioouts) {
                    this.gioouts = gioouts;
                }

                public int getColorType() {
                    return colorType;
                }

                public void setColorType(int colorType) {
                    this.colorType = colorType;
                }

                public TimeStamp getTimeStamp() {
                    return timeStamp;
                }

                public void setTimeStamp(TimeStamp timeStamp) {
                    this.timeStamp = timeStamp;
                }

                public String getLicense() {
                    return license;
                }

                public void setLicense(String license) {
                    this.license = license;
                }

                public int getCarColor() {
                    return carColor;
                }

                public void setCarColor(int carColor) {
                    this.carColor = carColor;
                }

                public int getIsoffline() {
                    return isoffline;
                }

                public void setIsoffline(int isoffline) {
                    this.isoffline = isoffline;
                }

                public int getColorValue() {
                    return colorValue;
                }

                public void setColorValue(int colorValue) {
                    this.colorValue = colorValue;
                }

                public Location getLocation() {
                    return location;
                }

                public void setLocation(Location location) {
                    this.location = location;
                }

                public int getTriggerType() {
                    return triggerType;
                }

                public void setTriggerType(int triggerType) {
                    this.triggerType = triggerType;
                }

                public int getDirection() {
                    return direction;
                }

                public void setDirection(int direction) {
                    this.direction = direction;
                }
            }
        }
    }
}
