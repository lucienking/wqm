package com.wqm.web.forum;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.wqm.common.persistence.SpecificationFactory;
import com.wqm.common.persistence.SearchFilter.Operator;
import com.wqm.entity.forum.BoardEntity;
import com.wqm.service.forum.BoardService;
import com.wqm.web.BaseController;

/**
 * 论坛-版块管理Controller
 * 
 * @author tangwl
 *
 */
@Controller
@RequestMapping(value = "/forum/board/")
public class BoardController extends BaseController{
	
	@Autowired
	private BoardService boardService;
	/**
	 * 版块管理界面<br/>
	 * 权限编码 006001
	 * @param model
	 * @return
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET,value = "/boardManager")
	@RequiresPermissions("006001")
	public String  boardManager(Model model){		 
		return "/forum/boardManager";
	}
	
	/**
	 * 分页查询菜单
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getBoardsPage")
	public Map<String,Object> getBoardsPage(HttpServletRequest request){
		//查询条件
		SpecificationFactory<BoardEntity> specf = new SpecificationFactory<BoardEntity>();
		specf.addSearchParam("name", Operator.LIKE, request.getParameter("boardName"));
		specf.addSearchParam("user.name", Operator.LIKE,  request.getParameter("userName"));
		specf.addSearchParam("authorId", Operator.LIKE,  request.getParameter("authorId"));
		specf.addSearchParam("parentId", Operator.EQ,  StringUtils.isBlank(request.getParameter("parentId"))?
				"":Long.valueOf(request.getParameter("parentId")));
		//分页排序信息
		Page<BoardEntity> boards= boardService.getBoardsByPage(specf.getSpecification(),buildPageRequest(request));
		return convertToResult(boards);
	}
	
	/**
	 * 获得全部的父菜单项，即所有的栏目。
	 * @return
	 */
	@ResponseBody
	@RequestMapping(method = RequestMethod.GET,value = "/getParents")
	public List<BoardEntity> getParents(){
		List<BoardEntity> boards= boardService.getAllParents();
		return boards;
	}
	
	/**
	 * 二次绑定效果： 即从数据库里先根据ID查出实体再与前台传来的部分属性绑定  
	 * 主要用于update 	
	 * 通用   在使用时加上 @ModelAttribute("board") 注解
	 * @param id
	 * @param model
	 */
	@ModelAttribute
	public void getBoard(@RequestParam(value = "id", defaultValue = "-1") Long id, Model model) {
		if (id != -1) {
			model.addAttribute("board", boardService.getBoardById(id));
		}
	}
	
	/**
	 * 更新菜单<br/>
	 * 权限编码 006001003
	 * @param board
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@RequiresPermissions("006001003")
	public Map<String,Object>  updateMenu(@Valid @ModelAttribute("board") BoardEntity board){
		Date date = new Date();
		board.setUpdateDate(date);
		board.setUser(this.getCurrentUser()); 
		boardService.saveBoard(board);
		return convertToResult("message","更新成功");
	}
	
	/**
	 *  删除菜单 <br/>
	 * 权限编码 007001002
	 * @param request
	 * @return Map<String,Object>
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	@RequiresPermissions("006001002")
	public Map<String,Object>  deleBoards(@Valid String ids){
		String [] idarr = ids.split(",");
		List<Long> idlist = new ArrayList<Long>();
		for(String id : idarr){
			idlist.add(Long.valueOf(id));
		}
		boardService.deleBoard(idlist);
		return convertToResult("message","删除成功");
	}
	
	/**
	 * 创建菜单<br/>
	 * 权限编码 007001001
	 * @param menu
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@RequiresPermissions("006001001")
	public Map<String,Object>  createBoard(@Valid BoardEntity board){
		Date date = new Date();
		board.setCreateDate(date);
		board.setUpdateDate(date);
		board.setUser(this.getCurrentUser()); 
		boardService.saveBoard(board);
		return convertToResult("message","新增成功");
	}
	
	/**
	 * 更改菜单状态<br/>
	 * 权限编码 007001003
	 * @param menu
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateStatus", method = RequestMethod.GET)
	@RequiresPermissions("007001003")
	public Map<String,Object>  updateMenuStatus(@Valid @ModelAttribute("board") BoardEntity board){
		Date date = new Date();
		board.setUpdateDate(date);
		board.setUser(this.getCurrentUser()); 
		boardService.saveMenu(board);
		return convertToResult("message","更新版块状态成功");
	}
}
