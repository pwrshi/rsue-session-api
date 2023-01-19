package com.example.rsue_session_api;

import android.annotation.TargetApi;
import android.os.Build;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;

import java.io.ByteArrayInputStream;
import androidx.annotation.NonNull;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

public class ScheduleApi implements api.ScheduleAPI {
    @Override
    public List<api.GroupSchedule> getAllGroups(byte[] file) {
        return parseBlob(file);
    }

    private List<api.GroupSchedule> parseBlob(byte[] file) {
        try {
            InputStream fileInputStream = new ByteArrayInputStream(file);
            HSSFWorkbook workbook = new HSSFWorkbook(fileInputStream);
            HSSFSheet worksheet = workbook.getSheet("1");
            String name = "";

            String groupName = null;
            List<api.GroupSchedule> result = new ArrayList<api.GroupSchedule>();
            List<api.SubjectInfo> subjects = new ArrayList<api.SubjectInfo>();

            HSSFCell cellA = null, cellB = null, cellC = null, cellD = null;

            for (int i = 12; !name.matches("Декан факультета"); i++) {
                HSSFRow row1 = worksheet.getRow(i);

                HSSFCell c;

                // check style
                c = row1.getCell((short) 0);
                if (!(c.getCellStyle().getBorderTop().equals(BorderStyle.NONE) && (c.getStringCellValue() == ""))) {
                    cellA = c;
                }
                name = cellA.getStringCellValue().replaceAll("\\s+", " ");

                c = row1.getCell((short) 1);
                if (!(c.getCellStyle().getBorderTop().equals(BorderStyle.NONE) && (c.getStringCellValue() == ""))) {
                    cellB = c;
                }
                List<String> teachers = new ArrayList<String>();
                teachers.add(cellB.getStringCellValue().replaceAll("\\s+", " "));

                c = row1.getCell((short) 2);
                if (!(c.getCellStyle().getBorderTop().equals(BorderStyle.NONE) && (c.getStringCellValue() == ""))) {
                    cellC = c;
                }
                String datetime = cellC.getStringCellValue().replaceAll("\\s+", " ");

                c = row1.getCell((short) 3);
                if (!(c.getCellStyle().getBorderTop().equals(BorderStyle.NONE) && (c.getStringCellValue() == ""))) {
                    cellD = c;
                }
                List<String> rooms = new ArrayList<String>();
                rooms.add( cellD.getStringCellValue().replaceAll("\\s+", " "));
                 if((teachers.get(0) == "") && (datetime == "") && (rooms.get(0) == "") && (name == "")) {
                     break;
                 } else if ((teachers.get(0) == "") && (datetime == "") && (rooms.get(0) == "")) {
                    if (groupName != null) {
                        api.GroupSchedule d = new api.GroupSchedule.Builder().setName(name).setExams(subjects).build();
                        result.add(d);
                    }
                    groupName = name;
                    subjects = new ArrayList<api.SubjectInfo>();
                } else {
                    api.MarkType type;
                    if (name.contains(" (экзамен)")) {
                        name = name.replace(" (экзамен)", "");
                        type = api.MarkType.EXAM;
                    } else if (name.contains(" (зачет)")) {
                        name = name.replace(" (зачет)", "");
                        type = api.MarkType.CREDIT;
                    } else {
                        name = name.replace(" (практика)", "");
                        type = api.MarkType.PRACTISE;
                    }

                    api.SubjectInfo s =new api.SubjectInfo.Builder().setName(name).setMark(type).setRooms(rooms).setDateTime(datetime)
                            .setTeachers(teachers).build();
                    if(subjects.size() != 0){
                        api.SubjectInfo b = subjects.get(subjects.toArray().length - 1);
                        boolean one = (Objects.equals(s.getName(), b.getName()));
                        boolean two = (Objects.equals(s.getDateTime(), b.getDateTime()));
                        boolean three = (String.join(" ", s.getRooms()).equalsIgnoreCase(String.join(" ", b.getRooms())));
                        boolean four = (String.join(" ", s.getTeachers()).equalsIgnoreCase(String.join(" ", b.getTeachers())));
                        boolean five = (s.getMark() == b.getMark());
                        if (one && two && three && four && five) {
                            break;
                        } else {
                            subjects.add(s);
                            
                        }
                        
                    } else {
                        subjects.add(s);
                    }

                }
            }
            // api.GroupSchedule d = new api.GroupSchedule.Builder().setName(name).setExams(subjects).build();
            // result.add(d);
            return result;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    @TargetApi(Build.VERSION_CODES.N)
    public api.GroupSchedule getGroupByName(byte[] file, String fname) {
        List<api.GroupSchedule> list = parseBlob(file);
        return (api.GroupSchedule) list.stream().filter(e -> e.getName() == fname).toArray()[0];
    }
}